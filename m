From: Massimo Mongardini <massimo@mongardini.it>
Subject: Re: spurious 'executable not found' errors
 on	nfs	automounted partition
Date: Mon, 29 Oct 2007 16:45:32 +0000
Message-ID: <47260E2C.1080409@mongardini.it>
References: <4721D6BA.5020003@mongardini.it>	
	<1193415615.3077.57.camel@raven.themaw.net>	
	<4725EB54.4070400@mongardini.it>
	<1193673686.3145.9.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169746769357509309=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1193673686.3145.9.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--===============1169746769357509309==
Content-Type: multipart/alternative;
	boundary="------------040005070600020402030200"

This is a multi-part message in MIME format.
--------------040005070600020402030200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> On Mon, 2007-10-29 at 14:16 +0000, Massimo Mongardini wrote:
>   
>> Ian Kent wrote: 
>>     
>>> On Fri, 2007-10-26 at 12:59 +0100, Massimo Mongardini wrote:
>>>   
>>>       
>>>> Hi everyone,
>>>>     I am experiencing an issue in the following circumstances:
>>>>
>>>> os: rhel4.5
>>>> kernel client: 2.6.9-55.0.9.ELsmp
>>>> kernel server: 2.6.9-55.0.2.ELsmp
>>>> autofs version 4.1.3-199.3
>>>>
>>>> server exports folder /nfs/folder with parameters:
>>>> async,rw,fsid=1,no_root_squash
>>>>
>>>> client automounts /nfs/folder with:
>>>>
>>>> auto.master:
>>>> /nfs    /etc/auto.nfs
>>>>
>>>> auto.nfs:
>>>> folder        -fstype=nfs,udp,rsize=32768,wsize=32768,noatime
>>>> fs-cluster:/nfs/folder
>>>>
>>>> default values for automount are --timeout 60
>>>>
>>>> If I run a script that checks with a series of increasing sleep
>>>> intervals < 120 if an exported file is executable,
>>>> I notice that if there is a coincidence between an unmount request and a
>>>> file request the file test fails
>>>>     
>>>>         
>>> This sounds like the mount/expire race patch and it's friends that
>>> aren't present in that kernel.
>>>
>>> There have been a few issues discussed around these patches (or the lack
>>> of them) on this list lately.
>>>
>>>   
>>>       
>>>> Thu Oct 25 17:00:28 GMT 2007 Error at DELAY: 38
>>>> Oct 25 17:00:28 server mountd[8014]: authenticated unmount request from
>>>> client:989 for /nfs/folder (/nfs/folder)
>>>> Fri Oct 26 04:48:41 GMT 2007 Error at DELAY: 25
>>>> Oct 26 04:48:41 server mountd[8014]: authenticated unmount request from
>>>> client:846 for /nfs/folder (/nfs/folder)
>>>>
>>>> the test script looks like this:
>>>>
>>>> EXECUTABLE="/nfs/folder/somepath/exec"
>>>> DELAY="1"
>>>> STOPCOUNT=120
>>>> OUT=$1
>>>> while true
>>>> do
>>>>  while [ "$DELAY" -lt "$STOPCOUNT" ]
>>>>   do
>>>>    test -x $EXECUTABLE
>>>>    if [ "$?" -ne "0" ]
>>>>     then
>>>>         echo "$(date) Error at DELAY: $DELAY" >> $OUT
>>>>     else
>>>>         echo "$(date) Executable found at DELAY: $DELAY" >> $OUT
>>>>    fi
>>>>    sleep $DELAY
>>>>   (( DELAY++ ))
>>>>  done
>>>> done
>>>>
>>>> any help is much appreciated
>>>>
>>>> cheers,
>>>> Massimo
>>>>
>>>>     
>>>>         
>>>   
>>>       
>> Ian, 
>> thanks for your answer.
>> I saw that bug but I thought was just related to  autofs4. Since the
>> client is running a maybe-patched 2.6.9-55.0.9.ELsmp version I thought
>> would be wnough. Am I missing something or some useful post?
>>
>> $ rpm -q --changelog kernel-smp-2.6.9-55.0.9.EL | grep -e autofs |
>> grep race
>> -revert: autofs4 fix for race between mount and expire [248126]
>>     
>
> This is the bit you should notice.
> The needed patches just aren't present.
>
>   
>> -autofs4: fix race between mount and expire (Ian Kent) [248126]
>> -autofs4: fix race between mount/expire (Jeff Moyer) [175778]
>>
>> The server has just:
>> $ rpm -q --changelog kernel-smp-2.6.9-55.0.2.EL | grep -e autofs |
>> grep race
>> -autofs4: fix race between mount/expire (Jeff Moyer) [175778]
>>     
>
> And this version would be OK if it had the needed corrections.
>
> Ian
>
>
>   
Ian,
It's clear now... I didn't notice the revert ... ;)
Thanks for your time, I'll just keep the mount points hard mounted until
a patched kernel will be released.

cheers
Massimo

-- 
Massimo Mongardini

_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_


echo 'Jg!J!hjwf!zpv!bo!bqqmf!boe!zpv!hjwf!nf!bo!bqqmf-!uifo!xf!xjmm!ibwf!bo!bqqmf!fbdi/!Cvu!jg!J!hjwf!zpv!bo!jefb!boe!zpv!hjwf!nf!bo!jefb-!xf!xjmm!ibwf!uxp!jefbt!fbdi!' | perl -pe 's/(.)/chr(ord($1)-1)/ge'


#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html



--------------040005070600020402030200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Ian Kent wrote:
<blockquote cite="mid:1193673686.3145.9.camel@raven.themaw.net"
 type="cite">
  <pre wrap="">On Mon, 2007-10-29 at 14:16 +0000, Massimo Mongardini wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Ian Kent wrote: 
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Fri, 2007-10-26 at 12:59 +0100, Massimo Mongardini wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">Hi everyone,
    I am experiencing an issue in the following circumstances:

os: rhel4.5
kernel client: 2.6.9-55.0.9.ELsmp
kernel server: 2.6.9-55.0.2.ELsmp
autofs version 4.1.3-199.3

server exports folder /nfs/folder with parameters:
async,rw,fsid=1,no_root_squash

client automounts /nfs/folder with:

auto.master:
/nfs    /etc/auto.nfs

auto.nfs:
folder        -fstype=nfs,udp,rsize=32768,wsize=32768,noatime
fs-cluster:/nfs/folder

default values for automount are --timeout 60

If I run a script that checks with a series of increasing sleep
intervals &lt; 120 if an exported file is executable,
I notice that if there is a coincidence between an unmount request and a
file request the file test fails
    
        </pre>
      </blockquote>
      <pre wrap="">This sounds like the mount/expire race patch and it's friends that
aren't present in that kernel.

There have been a few issues discussed around these patches (or the lack
of them) on this list lately.

  
      </pre>
      <blockquote type="cite">
        <pre wrap="">Thu Oct 25 17:00:28 GMT 2007 Error at DELAY: 38
Oct 25 17:00:28 server mountd[8014]: authenticated unmount request from
client:989 for /nfs/folder (/nfs/folder)
Fri Oct 26 04:48:41 GMT 2007 Error at DELAY: 25
Oct 26 04:48:41 server mountd[8014]: authenticated unmount request from
client:846 for /nfs/folder (/nfs/folder)

the test script looks like this:

EXECUTABLE="/nfs/folder/somepath/exec"
DELAY="1"
STOPCOUNT=120
OUT=$1
while true
do
 while [ "$DELAY" -lt "$STOPCOUNT" ]
  do
   test -x $EXECUTABLE
   if [ "$?" -ne "0" ]
    then
        echo "$(date) Error at DELAY: $DELAY" &gt;&gt; $OUT
    else
        echo "$(date) Executable found at DELAY: $DELAY" &gt;&gt; $OUT
   fi
   sleep $DELAY
  (( DELAY++ ))
 done
done

any help is much appreciated

cheers,
Massimo

    
        </pre>
      </blockquote>
      <pre wrap="">  
      </pre>
    </blockquote>
    <pre wrap="">Ian, 
thanks for your answer.
I saw that bug but I thought was just related to  autofs4. Since the
client is running a maybe-patched 2.6.9-55.0.9.ELsmp version I thought
would be wnough. Am I missing something or some useful post?

$ rpm -q --changelog kernel-smp-2.6.9-55.0.9.EL | grep -e autofs |
grep race
-revert: autofs4 fix for race between mount and expire [248126]
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is the bit you should notice.
The needed patches just aren't present.

  </pre>
  <blockquote type="cite">
    <pre wrap="">-autofs4: fix race between mount and expire (Ian Kent) [248126]
-autofs4: fix race between mount/expire (Jeff Moyer) [175778]

The server has just:
$ rpm -q --changelog kernel-smp-2.6.9-55.0.2.EL | grep -e autofs |
grep race
-autofs4: fix race between mount/expire (Jeff Moyer) [175778]
    </pre>
  </blockquote>
  <pre wrap=""><!---->
And this version would be OK if it had the needed corrections.

Ian


  </pre>
</blockquote>
Ian,<br>
It's clear now... I didn't notice the revert ... ;)<br>
Thanks for your time, I'll just keep the mount points hard mounted
until a patched kernel will be released.<br>
<br>
cheers<br>
Massimo<br>
<br>
<pre class="moz-signature" cols="90">-- 
Massimo Mongardini

_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_


echo 'Jg!J!hjwf!zpv!bo!bqqmf!boe!zpv!hjwf!nf!bo!bqqmf-!uifo!xf!xjmm!ibwf!bo!bqqmf!fbdi/!Cvu!jg!J!hjwf!zpv!bo!jefb!boe!zpv!hjwf!nf!bo!jefb-!xf!xjmm!ibwf!uxp!jefbt!fbdi!' | perl -pe 's/(.)/chr(ord($1)-1)/ge'


#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

Please avoid sending me Word or PowerPoint attachments.
See <a class="moz-txt-link-freetext" href="http://www.gnu.org/philosophy/no-word-attachments.html">http://www.gnu.org/philosophy/no-word-attachments.html</a>

</pre>
</body>
</html>

--------------040005070600020402030200--


--===============1169746769357509309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1169746769357509309==--

