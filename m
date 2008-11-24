From: Bill Shannon <bill.shannon@sun.com>
Subject: Re: Ubuntu NFS automount problem
Date: Sun, 23 Nov 2008 23:25:26 -0800
Message-ID: <492A56E6.1070603@sun.com>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1227499728.2913.0.camel@zeus.themaw.net>
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
> On Sat, 2008-11-22 at 18:27 -0800, Bill Shannon wrote:
>> I'm running Ubuntu 8.04 (Hardy Heron) on my desktop at home.
>> I have an OpenSolaris 2008.11 server and a Solaris 10 server.
>> Both servers export NFS filesystems.
>>
>> On my Ubuntu desktop, the autmounter doesn't want to automount hierarchical
>> filesystems.  I first noticed this with /home, but /net doesn't work either.
>>
>> My OpenSolaris server is named "nissan".  My Solaris server is named "nissan2".
>>
>> # showmount -e nissan
>> Export list for nissan:
>> /backup                 (everyone)
>> /backup/download        (everyone)
>> /export/home/admin      (everyone)
>> /backup/pictures        (everyone)
>> /export/home/shannon    (everyone)
>> /export/home            (everyone)
>> /export/home/readerware (everyone)
>> /backup2                (everyone)
>> /export/home/opt        (everyone)
>> # showmount -e nissan2
>> Export list for nissan2:
>> /export/home (everyone)
>> /backup      (everyone)
>> /backup2     (everyone)
>> # cat /etc/auto.net
>> *	-rw,intr	&:/
> 
> How is do you expect this to work, explain?

The simple answer is - the same way it works on Solaris and Mac OS.

I should see the following directories:

/net/nissan/backup
/net/nissan/backup/download
/net/nissan/backup/pictures
/net/nissan/export
/net/nissan/export/home
/net/nissan/export/home/shannon

and so on.

After autofs mounts nissan:/backup on /net/nissan, it then
needs to mount nissan:/backup/download on /net/nissan/backup/download.

And in the case of nissan:/export, there's nothing to mount on
/net/nissan/export, so autofs needs to create a pseudo-directory
that contains an entry for "home".

Understand?
