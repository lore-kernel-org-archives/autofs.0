From: Bill Shannon <bill.shannon@sun.com>
Subject: Re: Ubuntu NFS automount problem
Date: Mon, 24 Nov 2008 07:42:16 -0800
Message-ID: <492ACB58.7040805@sun.com>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net>
	<492A56E6.1070603@sun.com>
	<1227531120.2913.9.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1227531120.2913.9.camel@zeus.themaw.net>
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

Ian Kent wrote:
> On Sun, 2008-11-23 at 23:25 -0800, Bill Shannon wrote:
>> Ian Kent wrote:
>>> On Sat, 2008-11-22 at 18:27 -0800, Bill Shannon wrote:
>>>> I'm running Ubuntu 8.04 (Hardy Heron) on my desktop at home.
>>>> I have an OpenSolaris 2008.11 server and a Solaris 10 server.
>>>> Both servers export NFS filesystems.
>>>>
>>>> On my Ubuntu desktop, the autmounter doesn't want to automount hierarchical
>>>> filesystems.  I first noticed this with /home, but /net doesn't work either.
>>>>
>>>> My OpenSolaris server is named "nissan".  My Solaris server is named "nissan2".
>>>>
>>>> # showmount -e nissan
>>>> Export list for nissan:
>>>> /backup                 (everyone)
>>>> /backup/download        (everyone)
>>>> /export/home/admin      (everyone)
>>>> /backup/pictures        (everyone)
>>>> /export/home/shannon    (everyone)
>>>> /export/home            (everyone)
>>>> /export/home/readerware (everyone)
>>>> /backup2                (everyone)
>>>> /export/home/opt        (everyone)
>>>> # showmount -e nissan2
>>>> Export list for nissan2:
>>>> /export/home (everyone)
>>>> /backup      (everyone)
>>>> /backup2     (everyone)
>>>> # cat /etc/auto.net
>>>> *	-rw,intr	&:/
>>> How is do you expect this to work, explain?
>> The simple answer is - the same way it works on Solaris and Mac OS.
> 
> I asked you "how" is this supposed to work not "what" you think is is
> supposed to be the result.

Sorry, I'm just *using* this software, not designing it.  The "how" is
up to you.

>> I should see the following directories:
>>
>> /net/nissan/backup
>> /net/nissan/backup/download
>> /net/nissan/backup/pictures
>> /net/nissan/export
>> /net/nissan/export/home
>> /net/nissan/export/home/shannon
> 
> I can't see how the above map entry can provide these mappings and if
> you can't provide an accurate description of how the mounts are
> constructed I can't tell you whether Linux autofs can, either do what
> you expect or be updated to do what you expect.

I'm sorry you don't understand.  I gave you the most complete description
of how this works that I can.  I'm not sure what's so confusing to you.

Under /net/<hostname> I want to see a filesystem hierarchy that matches
all the exported filesystems from the host.  If the host exports *every*
filesystem, then I would want to see a hierarchy that matches exactly
what I see on the host.  In most cases a host won't export everything,
so autofs has to fill in some parts of the hierarchy with pseudo-directories.

Do you see how the list of exported directories is not a flat namespace
but can actually be arranged into a hierarchy?  How some exported directories
appear "inside" other exported directories?

Maybe if you can explain more clearly what it is that's confusing you I
can help.

>> and so on.
>>
>> After autofs mounts nissan:/backup on /net/nissan, it then
>> needs to mount nissan:/backup/download on /net/nissan/backup/download.
>>
>> And in the case of nissan:/export, there's nothing to mount on
>> /net/nissan/export, so autofs needs to create a pseudo-directory
>> that contains an entry for "home".
>>
>> Understand?
> 
> No, I don't understand at all, but that's because you've not provided
> any useful information.
> 
> Where in the Solaris documentation is the behavior of this type of map
> entry described.

I don't know.  It's worked this way in Solaris for 20 years.  It's been
a long time since I've read the documentation.  Where did you look in
the Solaris documentation to figure this out?

Have you ever *tried* this on Solaris?  I think a little experimenting
would show you how it works.

I have to say, it's a bit disappointing that you don't understand how the
corresponding Solaris version works, since it's clearly the de facto
standard for this technology.
