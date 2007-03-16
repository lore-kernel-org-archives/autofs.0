From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Thu, 15 Mar 2007 19:41:45 -0700
Message-ID: <45FA03E9.8020901@soe.ucsc.edu>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174008860.3397.9.camel@raven.themaw.net>
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

Hi Ian,

Fantastic!  Just what I needed, all is well now.  Thanks a million for 
the insight!

Regards,
erich

Ian Kent wrote:
> On Thu, 2007-03-15 at 15:05 -0700, weiler@soe.ucsc.edu wrote:
>> Hey all-
>>
>> I'm testing out CentOS 5 (i.e. RedHat 5) and and playing around with
>> autofs 5.0.1 which is the version that ships with it.  I'm noticing three
>> odd things based on what I was seeing in RedHat 4.4 (which has autofs
>> 4.1.3):
>>
>> 1: Before, with autofs 4.1.3, I had in /etc/nsswitch.conf:
>>
>> automount: files ldap
>>
>> And I had some maps in /etc/auto.master that mounted AND I had some maps
>> in LDAP that mounted, both worked OK together.  But in Autofs 5.0.1, the
>> same line in nsswitch.conf only lets me use whatever is first, i.e. if
>> files is listed first it automounts with flat files but not LDAP, or vice
>> versa.  Is there any way to get them BOTH working again, or is this a
>> nifty feature that has been removed?
> 
> That's correct.
> That's the behavior of other industry standard automounters.
> Adding a plus include line at the end of /etc/auto.master (as in the
> default configuration) will allow the inclusion of the LDAP master map
> in the above example.
> 
>> 2: When it loads flat files from auto.master locally, I see all the maps
>> mount at once randomly, i.e. if I have 1 map with 10 mounts listed in it,
>> I see them ALL mount at once!  Even though I didn't access them.  They
>> seem to come and go randomly...  Is this normal with autofs 5?
> 
> No, you have a process accessing the filesystems.
> Find out what it is and get an update for it.
> Using debug logging for a little while may help to identify the culprit
> as version 5 logs the requesting pid. Don't forget to make sure daemon.*
> is being logged somewhere. 
> 
>> 3: I used to see this when I did a "ps -ef | grep automount" in autofs 4.1.3:
>>
>> % ps -ef | grep automount
>> [root@lutra ~]# ps -ef | grep automount
>> root      3373     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
>> --timeout=6000 /cluster file /etc/auto.cluster intr
>> root      3442     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
>> --timeout=6000 /share file /etc/auto.share
>> root      3489     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
>> --timeout=60 --ghost /home ldap nisMapName=auto.home,dc=someuniv,dc=edu
>> -hard,intr,rw
>> root      3565     1  0 Mar14 ?        00:00:00 /usr/sbin/automount
>> --timeout=60 --ghost /projects ldap
>> nisMapName=auto.projects,dc=someuniv,dc=edu -hard,intr,rw
>>
>> But now all I see on 5.0.1 is:
>>
>> % ps -ef | grep automount:
>> root     25274     1  0 14:43 ?        00:00:00 automount
>> root     25451 18488  0 15:02 pts/1    00:00:00 grep automount
>>
>> Not nearly as descriptive as to *what* is actually live or not...
> 
> Yes, version 5 uses POSIX threads instead of processes.
> You won't see the autofs file system mounts in /etc/mtab anymore either.
> Check /proc/mounts to see the autofs mounts and use the list threads
> option in ps if you want more information.
> 
> Ian
> 
