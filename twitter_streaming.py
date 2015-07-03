try:
	import json
except ImportError:
	import simplejson as json 

#Import the necessary methods from "twitter" libgrary
from twitter import Twitter, OAuth, TwitterHTTPError, TwitterStream

#Variables that contains the user credentials to access Twitter API
ACCESS_TOKEN = "14701057-9LHglQUPDoOJ55qaMhHTBfA91IhBuZkCloPl4iMHE"
ACCESS_SECRET = "a7qoTjOGe4OqwB9mg01bwmkqw7yvR5BCXohEYqxh2hTv7"
CONSUMER_KEY = "b35qDXN6VvNpsxnqoFTDDll6U"
CONSUMER_SECRET = "uux9vLwKAXhaJuNJRajcu8DOCvn0LhdxRwHE0m62y3eUZTJpLv"

oauth = OAuth(ACCESS_TOKEN, ACCESS_SECRET, CONSUMER_KEY, CONSUMER_SECRET)

#Initiate the connection to Twitter Streaming API
twitter_stream = TwitterStream(auth=oauth)

#Get a sample of the public data following throough Twitter
iterator = twitter_stream.statuses.sample()

#Print each tweet in the stream to the screen
#Here we set it to stop after getting 1000 tweets.
#You don't have to set it to stop, but can continue running
#the Twitter API to collect data for days or even longer.
tweet_count = 1000
for tweet in iterator:
	tweet_count -= 1
	#Twitter Python Tool wraps the data returned by Twitter
	#as a TwitterDictResponse object. 
	#We convert it back to the JSON format to print/score
	print (json.dumps(tweet))
	if tweet_count <= 0:
		break