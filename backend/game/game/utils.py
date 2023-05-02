from rest_framework.response import Response
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