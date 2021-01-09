import flask
from flask import request, jsonify
import os 

app = flask.Flask(__name__)
app.config["DEBUG"] = True

sha_list=os.popen('git ls-remote https://github.com/akashsahu-gh/technical-tests-master.git').readlines()
matching = [s for s in sha_list if "HEAD" in s]
sha=str(matching[0]).replace('\tHEAD\n','')

re={ "myApplication" : [ 
    {   'version': 0, 
        "lastcommitsha": sha, 
        "Description:": "Pre-interview technical test" 
    }] 
    }

import base64
import requests


url = 'https://api.github.com/repos/{user}/{repo_name}/contents/{path_to_file}'
req = requests.get(url)
if req.status_code == requests.codes.ok:
    req = req.json()
    content = base64.decodestring(req['content'])
else:
    print('Content was not found.')


@app.route('/', methods=['GET'])
def home():
    return '''<h1>Distant Reading Archive</h1>
<p>Tests program to get version and sha for Application from GitHub Repo</p>'''

# A route to return all of the available entries in our catalog.
@app.route('/api/version', methods=['GET'])
def api_all():
    return jsonify(re)


if __name__ == '__main__':
      app.run(host='0.0.0.0', port=8000)