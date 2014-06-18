### rake task to send a daily digest from CampfireNow aka Campfire

I was having trouble getting business owners to stay tuned in campfire. But the developers were giving so quality updates and I need to get those out to a broader audience. So I created a rake task to simply do that. 

You need to construct a YAML file that has your user id's and translates them into Readable Names. Also I stashed my configs in the same file so that I could just exclude that file from the project. It would not take you but  minute to create it. 

Here's an example.

####bot.yml
m_1155555: 'Billy'
m_1199999: 'Bob'
user: 'API KEY FROM CAMPFIRENOW.com'
pass: 'PASS For Account'
url: 'https://yourAPP.campfirenow.com/room/ROOMID/transcript.xml'
email_user: 'no-reply@yourdomain.com'
email_pass: 'Password' 

You could change the code and use ENV varibles if that suites you. 

###TODO
Pull users and persist them some how so that you don't have to do this whole yaml thing. 


