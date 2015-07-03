try:
	import json
except ImportError:
	import simplejson as json

#use file saved from last step as example
tweets_filename = "twitter_stream_1000tweets.txt"
tweets_file = open(tweets_filename, "r")

for line in tweets_file:
	try:
		#Read one line of file, convert into json object
		tweet = json.loads(line.strip())
		if "text" in tweet:
			print (tweet["id"]) #tweet's id
			print (tweet["created_at"]) #when tweet was posted
			print (tweet["text"]) #content of tweet

			print (tweet["user"]["id"]) #id of user who posted tweet
			print (tweet["user"]["name"]) # name of user
			print (tweet["user"]["screen_name"]) #name of user account

			hashtags = []
			for hashtags in tweet["entities"]["hashtags"]:
				hashtags.append(hashtag["text"])
			print (hashtags)

	except:
		continue