from django.db import models

# Create your models here.
class User(models.Model):
    username=models.CharField(max_length=200, null=False)
    password=models.CharField(max_length=300,)
    def __str__(self):
        return self.username