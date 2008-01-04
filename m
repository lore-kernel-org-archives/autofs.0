From: Jim Duda <jim@duda.tzo.com>
Subject: Re: automount won't start - just hangs
Date: Thu, 03 Jan 2008 22:48:58 -0500
Message-ID: <flkaba$dpm$1@ger.gmane.org>
References: <flbove$pg9$1@ger.gmane.org>	<1199188197.3246.1.camel@raven.themaw.net>	<fldr8g$t60$1@ger.gmane.org>	<1199238944.3072.10.camel@raven.themaw.net>	<flgmj7$j1l$1@ger.gmane.org>	<1199325175.3175.9.camel@raven.themaw.net>	<flk3m8$uuv$1@ger.gmane.org>	<1199413407.3288.39.camel@raven.themaw.net>
	<flk5ru$3ot$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <flk5ru$3ot$1@ger.gmane.org>
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
To: autofs@linux.kernel.org

Ian,

Here in spawn.c

		errp = 0;
		do {
			while ((errn =
				read(pipefd[0], errbuf + errp, ERRBUFSIZ - errp)) == -1
			       && errno == EINTR);


Jim Duda wrote:
> Ian,
> 
> I do have daemon.*, I got it backwards in the last post.
> 
> I downloaded autofs-5.0.2.tar.gz, do you want me to download 5.1.31 ?
> 
> Jim
> 
> Ian Kent wrote:
>> On Thu, 2008-01-03 at 20:55 -0500, Jim Duda wrote:
>>> Ian,
>>>
>>> Adding *.daemon simply resulted in the same information being dumped to 
>>> the syslog file, however, twice.  So, no new information.
>> That should be daemon.* and usually you would log it to a different file
>> when adding a syslog entry like that but I don't think that will make
>> any difference.
>>
>> I can't remember how logging to a syslog server works now but does the
>> syslog configuration on the server also limit what is logged?
>>
>>> Once automount gets wedged, I cannot use gdb to interrogate the threads, 
>>> I cannot break into the program after it's wedged.
>>>
>>> I'm by no means a power gdb user.
>> Me nether.
>>
>>> I did:
>>>
>>> set detach-on-fork off, simply based on a recommended help from ddd.
>>>
>>> I traced the program all the way down into mount_bind.c, in the 
>>> mount_init function, then into spawn.c, where it did the first fork. 
>>> The program was wedged in spawn.c on line 186 at the first do while loop 
>>> after the fork.
>>>
>>> The program though do_read_master, mod->lookup_int, then into open_mount 
>>> for "nfs" before it got to the first spawn.
>>>
>>> I don't know how helpful any of this information is for you in helping 
>>> me determine what is different about my funky root file system which 
>>> causes a lockup, but thanks for trying.
>> I'm not sure either but one thing is sure, problems are almost always
>> different from what you think they are when you finally get hard
>> evidence.
>>
>> In autofs-5.0.1-31, line 186 corresponds to an if statement?
>>
>> How about we try getting rid of a recent patch to this area of the code
>> and rebuild autofs and see if that helps. The one I have in mind is
>> close to the chopping block already.
>>
>> In particular:
>>
>> [raven@raven F-7]$ cvs diff -u autofs.spec 
>> Index: autofs.spec
>> ===================================================================
>> RCS file: /cvs/pkgs/rpms/autofs/F-7/autofs.spec,v
>> retrieving revision 1.221
>> diff -u -r1.221 autofs.spec
>> --- autofs.spec 21 Dec 2007 10:21:18 -0000      1.221
>> +++ autofs.spec 4 Jan 2008 02:20:20 -0000
>> @@ -127,7 +127,7 @@
>>  %patch35 -p1
>>  %patch36 -p1
>>  %patch37 -p1
>> -%patch38 -p1
>> +#%patch38 -p1
>>  %patch39 -p1
>>  
>>  %build
