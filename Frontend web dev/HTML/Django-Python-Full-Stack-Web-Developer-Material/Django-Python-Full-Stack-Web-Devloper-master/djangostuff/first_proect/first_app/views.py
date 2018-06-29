from django.shortcuts import render

from first_app.models import AccessRecord, Webpage, Topic

# Create your views here.
from django.http import HttpResponse

def index(res):
    Webpage_list = AccessRecord.objects.order_by('date')
    date_dict = {'access_records':Webpage_list}

    return render(res,'first_app/index.html',context=date_dict)
