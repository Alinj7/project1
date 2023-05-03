from django.db import models

# Create your models here.
class Match(models.Model):
    player1=models.IntegerField(default=0)
    player2=models.IntegerField(default=0)
    hplayer1=models.IntegerField(default=2000)
    hplayer2=models.IntegerField(default=2000)
    status=models.IntegerField(default=0)
    turn=models.IntegerField(default=1)
    def __str__(self):
        if(self.status==1):
            return "active game"
        elif(self.status==0):
            return "wait for other players"