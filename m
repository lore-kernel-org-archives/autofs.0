From: Hans Deragon <hans@deragon.biz>
Subject: Re: backfstype parameter supported.
Date: Tue, 29 Jun 2004 10:40:15 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E17F4F.6060307@deragon.biz>
References: <40E1632D.1080903@deragon.biz>
 <Pine.LNX.4.58.0406292140380.14746@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.58.0406292140380.14746@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Inline.

raven@themaw.net wrote:
> On Tue, 29 Jun 2004, Hans Deragon wrote:
 >
>>  cachefs is not supported by Linux.  In a mix Solaris/Linux environment,
>>where NIS is provided by Solaris, many yp maps specify cachefs as the
>>filesystem, but backfstype is set to nfs.  Automount does not support backfstype.
> 
> Yes. Handling unknown options is a headache and needs attention.
> 
> I haven't been able to work on this at all and I haven't really 
> thought a great deal about how we can handle it in a clean way.
>  
> 
>>  Here is a exert of an entry:
>>
>>.. fstype=cachefs,cachedir=<dir>,backfstype=nfs ...
>>
>>  I changed the code and now I have a modified 4.1.3 version which tries for
>>the filesystem defined with "fstype" and if this fails, "backfstype" is then
>>tried.  It works.
>>
>>  My patch is not perfect though.  While trying "cachefs", modprobe errors
>>shows up in /var/log/messages.  Until backfstype also fails, ideally no error
>>message should be emitted.  Maybe there is a way to test for the existance of
>>the kernel module before actually try to load it, thus avoiding error messages.
> 
> Those messages are difficult to eliminate as they often come from 
> mount(8) itself.

In cachefs case, we know that Linux does not support it.  Should we simply catch 
it and immediately try the backfstype?  This would avoid the errors.

Is automount used on any OS where cachefs is supported?  Anyhow, I could 
implement a #ifdef LINUX statement which will catch cachefs only for Linux OS. 
Anybody knows of an actual macro I could use to figure out if the kernel is Linux?

>>  Altough I am a programmer, I do not program in C and do know pratically
>>nothing about system calls.  I would like my patch to be accepted in the main
>>branch and that someone experienced with autofs clean it up.
>>
>>  Please comment.  I would be glade to send you the patch, but first I have to
>>read "man patch" to figure out how to generate one. :)  Its a pretty small
>>change to the code.
> 
> 
> Certainly, send the patch over.
> 
> But please be aware that I can't say when I will merge it.
> There's a backlog. I've had some patches for ages and when I start work on 
> them I seem to get side tracked onto bug fixes and the like.

Rgr.  I will submit it once I have refined it a bit more.

> Fact is if it looks like it won't produce side effects, has no hard coded 
> paths and works straight out then there's a good chance.

For the moment, it is the case.  Pretty simple patch.


Thanks,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)
