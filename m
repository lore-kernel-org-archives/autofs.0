From: Jonathan Loran <jonathan@loran.name>
Subject: Re: Problem between autofs 3 and autofs4
Date: Sun, 23 Apr 2006 10:31:07 -0700
Message-ID: <444BB9DB.4060703@loran.name>
References: <042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2513597769029092884=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: ergatz@comcast.net
Cc: autofs mailing list <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============2513597769029092884==
Content-Type: multipart/alternative;
	boundary="------------040109070702000603060902"

This is a multi-part message in MIME format.
--------------040109070702000603060902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit




ergatz@comcast.net wrote:
> I tried all sorts of things, to include autofs reload, autofs stop and start, ypbind stop and start.
> The only thing that would work was too reboot the machine.  Rebooting a SERVER is not
> really something I want to do when I make changes.
>
> One of the guys in the office found an updated version of autofs.  I installed it, and everything
> works like a charm.  
>
> A commentary:  I found somewhere that autofs 4 was written by someone who did not write
> autofs3.  In fact, the author of 3 said he would like to come back to write 5.  It seems the author
> of 4 did not know as much about autofs as he should have to write properly functioning code.
>
>   
I just have to chime in here, that though Ian Kent may sometimes be self
deprecating, it is not at all fair to say this about him.  He has given
so much of himself to the autofs project, and he, at least at this date,
is hardly ignorant as to how autofs works.  I for one feel extremely
grateful to him for his tireless hard work on this project.  Cheers to Ian!

Jon

> Just one of my many frustrations with Redhat and open source....
>
>
>
>
>
>  -------------- Original message ----------------------
> From: Ian Kent <raven@themaw.net>
>   
>> On Sat, 15 Apr 2006, ergatz wrote:
>>
>>     
>>> I have a Solaris 2.6 NIS server and have recently added some Redhat Linux 
>>>       
>> hosts to it.
>>     
>>> I have:
>>>
>>>      1 RH 7.3 machine
>>>      2 RH 3.0 update 0
>>>      1 RH 3.0 update 3
>>>      2 RH 4.0 machines
>>>
>>> I have looked at this problem a lot, and the difference I see is that 7.3 and 
>>>       
>> 3.0U0 use autofs 3.
>>     
>>> The 4.0 and 3.0U3 machines use autofs 4
>>>
>>> My problem is:  When I moved some users' home directories to a different 
>>>       
>> partition, the RH machines using autofs 4 had to be rebooted to pick up the 
>> changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) picked up 
>> the changed locations magically like they are supposed to.  The machines using 
>> autofs 4 had to be rebooted in order to pick up the changes.  I tried everything 
>> I could think of to avoid reboot, because multiple users are on the the system 
>> at all times.
>>     
>>> I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing worked.
>>>       
>> Did you try "service autofs reload".
>>
>> or 
>>
>> /etc/init.d/autofs reload
>>
>> ?
>>
>>     
>>> So, who know the differences between autofs 3 and 4, and what can I do to 
>>>       
>> hosts running autofs 4 to get them to pick up the NIS changes without having to 
>> reboot?
>>     
>>> dorothy
>>>       
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
>>     
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   

--------------040109070702000603060902
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<br>
<br>
<a class="moz-txt-link-abbreviated" href="mailto:ergatz@comcast.net">ergatz@comcast.net</a> wrote:
<blockquote
 cite="mid042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net"
 type="cite">
  <pre wrap="">I tried all sorts of things, to include autofs reload, autofs stop and start, ypbind stop and start.
The only thing that would work was too reboot the machine.  Rebooting a SERVER is not
really something I want to do when I make changes.

One of the guys in the office found an updated version of autofs.  I installed it, and everything
works like a charm.  

A commentary:  I found somewhere that autofs 4 was written by someone who did not write
autofs3.  In fact, the author of 3 said he would like to come back to write 5.  It seems the author
of 4 did not know as much about autofs as he should have to write properly functioning code.

  </pre>
</blockquote>
I just have to chime in here, that though Ian Kent may sometimes be
self deprecating, it is not at all fair to say this about him.&nbsp; He has
given so much of himself to the autofs project, and he, at least at
this date, is hardly ignorant as to how autofs works.&nbsp; I for one feel
extremely grateful to him for his tireless hard work on this project.&nbsp;
Cheers to Ian!<br>
<br>
Jon<br>
<br>
<blockquote
 cite="mid042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net"
 type="cite">
  <pre wrap="">Just one of my many frustrations with Redhat and open source....





 -------------- Original message ----------------------
From: Ian Kent <a class="moz-txt-link-rfc2396E" href="mailto:raven@themaw.net">&lt;raven@themaw.net&gt;</a>
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Sat, 15 Apr 2006, ergatz wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">I have a Solaris 2.6 NIS server and have recently added some Redhat Linux 
      </pre>
    </blockquote>
    <pre wrap="">hosts to it.
    </pre>
    <blockquote type="cite">
      <pre wrap="">I have:

     1 RH 7.3 machine
     2 RH 3.0 update 0
     1 RH 3.0 update 3
     2 RH 4.0 machines

I have looked at this problem a lot, and the difference I see is that 7.3 and 
      </pre>
    </blockquote>
    <pre wrap="">3.0U0 use autofs 3.
    </pre>
    <blockquote type="cite">
      <pre wrap="">The 4.0 and 3.0U3 machines use autofs 4

My problem is:  When I moved some users' home directories to a different 
      </pre>
    </blockquote>
    <pre wrap="">partition, the RH machines using autofs 4 had to be rebooted to pick up the 
changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) picked up 
the changed locations magically like they are supposed to.  The machines using 
autofs 4 had to be rebooted in order to pick up the changes.  I tried everything 
I could think of to avoid reboot, because multiple users are on the the system 
at all times.
    </pre>
    <blockquote type="cite">
      <pre wrap="">I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing worked.
      </pre>
    </blockquote>
    <pre wrap="">Did you try "service autofs reload".

or 

/etc/init.d/autofs reload

?

    </pre>
    <blockquote type="cite">
      <pre wrap="">So, who know the differences between autofs 3 and 4, and what can I do to 
      </pre>
    </blockquote>
    <pre wrap="">hosts running autofs 4 to get them to pick up the NIS changes without having to 
reboot?
    </pre>
    <blockquote type="cite">
      <pre wrap="">dorothy
      </pre>
    </blockquote>
    <pre wrap="">_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->

_______________________________________________
autofs mailing list
<a class="moz-txt-link-abbreviated" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a>
<a class="moz-txt-link-freetext" href="http://linux.kernel.org/mailman/listinfo/autofs">http://linux.kernel.org/mailman/listinfo/autofs</a>
  </pre>
</blockquote>
</body>
</html>

--------------040109070702000603060902--


--===============2513597769029092884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2513597769029092884==--

