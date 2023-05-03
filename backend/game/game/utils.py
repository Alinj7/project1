from rest_framework.response import Response
import jwt
from users.models import User
def itemChecker(tobj,items=[]):
    for i in items:
        if(i in tobj):pass
        else:return {"error":str(i)+" not entered"}
    return False
def dataAndStatus(data,status=True):
    return Response({
        "status":status,
        "data":data
    })
def encodeJWT(payload):
    try:return  jwt.encode(payload, 'unsecurescretkey')
    except:return False
def decodeJWT(cipher):
    try: return jwt.decode(cipher,'unsecurescretkey',algorithms="HS256")
    except:return False
def isAUTH(request):
    header=request.headers
    if('token' in header):
        uid=decodeJWT(header['token'])
        if(uid):
            try:
                User.objects.get(id=uid['id'])
                return {"id":uid['id']}
            except:return False
        else:return False
    else:return False