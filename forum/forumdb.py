#
# Database access functions for the web forum.
#

import psycopg2

## Database connection
DB = psycopg2.connect('dbname=forum')

## Get posts from database.
def GetAllPosts():
    '''Get all the posts from the database, sorted with the newest first.

    Returns:
      A list of dictionaries, where each dictionary has a 'content' key
      pointing to the post content, and 'time' key pointing to the time
      it was posted.
    '''

    cursor = DB.cursor()
    cursor.execute('select content, time from posts order by time desc')
    posts = [{'content': post[0], 'time': post[1]} for post in cursor.fetchall()]
    cursor.close()

    return posts

## Add a post to the database.
def AddPost(content):
    '''Add a new post to the database.

    Args:
      content: The text content of the new post.
    '''
    cursor = DB.cursor()
    cursor.execute('insert into posts values (%s)', (content,))
    cursor.close()
    DB.commit()
