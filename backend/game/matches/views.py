from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from game.utils import dataAndStatus,itemChecker,isAUTH
from .models import Match
# Create your views here.
@api_view(["POST"])
def createMatch(request):
    data=request.data
    uid=isAUTH(request)
    checkI=itemChecker(data,["hplayer1"])
    if(checkI and uid==False):
       return Response(checkI)
    else:
        createMatch=Match.objects.create(hplayer1=data['hplayer1'],player1=uid['id']).__dict__
        createMatch.pop("_state")
        return dataAndStatus(createMatch)
@api_view(["POST"])
def findMatch(request):
    data=request.data
    uid=isAUTH(request)
    checkI=itemChecker(data,["hplayer2"])
    if(checkI and uid==False):
       return Response(checkI)
    else:
        findematch=Match.objects.filter(status=0)
        if(len(findematch)):
            findematch=findematch[0].__dict__
            findematch.pop("_state")
            return dataAndStatus(findematch)
        else:
            request.data['hplayer1']=data['hplayer2']
            return dataAndStatus("not found any match",status=False)