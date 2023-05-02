from django.contrib import admin
from .models import User
# Register your models here.
class AdminUsers(admin.ModelAdmin):
    search_fields = ('username',)
    list_filter = ('username',)
    empty_value_display = '-empty field-'

admin.site.register(User)