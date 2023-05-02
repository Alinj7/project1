from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.shortcuts import render
from .models import User
from game.utils import dataAndStatus,itemChecker
from hashlib import sha256
# Create your views here.
@api_view(['POST'])
def createUser(request):
    data=request.data
    checkI=itemChecker(data,["username","password"])
    if(checkI):
       return Response(checkI)
    else:
        createdUser=User.objects.create(
            username=data['username'],
            password=sha256(data['password'].encode("utf8")).hexdigest()
            ).__dict__
        createdUser.pop("_state")
        return dataAndStatus(createdUser)
     