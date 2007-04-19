From: Ian Kent <raven@themaw.net>
Subject: Re: Strange issue with autofs5/fc6
Date: Thu, 19 Apr 2007 12:15:38 +0800
Message-ID: <1176956138.3370.36.camel@raven.themaw.net>
References: <46264599.90105@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46264599.90105@kmaclub.com>
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
To: Michael <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2007-04-18 at 09:21 -0700, Michael wrote:
> I am seeing some weird behavior with autofs/mount. 
> 
> /proc/mounts, mounts, and auto.master don't seem to agree.
> 
> /proc/mounts:
> filer:/export/users/mythtv /home/mythtv nfs 
> rw,vers=3,rsize=262144,wsize=262144,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=filer 
> 0 0
> 
> mount:
> filer:/export/users/mythtv on /home/mythtv type nfs (rw,addr=192.168.101.1)
> 
> Here is my auto.master
> ypcat -k auto.master
> /home auto.home 
> bg,hard,intr,retry=10000,rsize=8192,wsize=8192,acregmin=3,acregmax=60,acdirmin=30,acdirmax=60,timeo=600,retrans=5,nfsvers=3,tcp
> 
> The 262144 size is strange and I don't have any idea where that is 
> coming from.
> 
> Also, mounting by hand:
> 
> [root@client ~]# mount -o rsize=8192,wsize=8192 
> filer:/export/users/mythtv /mnt
> [root@client ~]# mount | grep mnt
> filer:/export/users/mythtv on /mnt type nfs 
> (rw,rsize=8192,wsize=8192,addr=192.168.101.1)
> [root@client ~]# grep mnt /proc/mounts
> filer:/export/users/mythtv /mnt nfs 
> rw,vers=3,rsize=262144,wsize=262144,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=filer 
> 0 0
> 
> Any thoughts on what is happening here?  Is rsize really 262144 or are 
> things being reported incorrectly?

I don't know.
I haven't noticed this before but that's certainly odd.
Maybe the folks on nfs-list will be able to help.

Ian
