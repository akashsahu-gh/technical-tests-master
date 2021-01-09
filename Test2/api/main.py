import flask
from flask import request, jsonify
import os 
import requests

app = flask.Flask(__name__)
#app.config["DEBUG"] = True


#Get last sha commit from gitub repo
sha_list=os.popen('git ls-remote https://github.com/akashsahu-gh/technical-tests-master.git').readlines()
matching = [s for s in sha_list if "HEAD" in s]
sha=str(matching[0]).replace('\tHEAD\n','')

#Get application version from file stored in github
url = 'https://raw.githubusercontent.com/akashsahu-gh/technical-tests-master/master/Test2/api/app_version'
content=requests.get(url).content

result={ "myApplication" : [ 
    {   'version': content, 
        "lastcommitsha": sha, 
        "Description:": "Pre-interview technical test" 
    }] 
    }

@app.route('/', methods=['GET'])
def home():
    return '''<h1>Test Program for ANZx</h1>
<p>Tests program to get version and sha for Application from GitHub Repo</p>'''

# A route to return all of the available entries in our catalog.
@app.route('/api/version', methods=['GET'])
def api_all():
    return jsonify(result)


if __name__ == '__main__':
      app.run(host='0.0.0.0', port=8000)