From: Ian Kent <raven@themaw.net>
Subject: Re: basic question on "key"
Date: Wed, 6 Oct 2004 15:59:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410061552130.13975@wombat.indigo.net.au>
References: <4162C97A.7080407@javanet.info>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4162C97A.7080407@javanet.info>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: es <es.autofs@javanet.info>
Cc: autofs@linux.kernel.org

On Tue, 5 Oct 2004, es wrote:

> Hello there, I'm using autofs since a while and works very well.
> Now I'd like to mount /home/milly and /home/es/Data from an NFS export. 
> This means I cannot simply have /home in auto.master otherwise /home/es 
> became inaccesible.
> ********* auto.master file
> /home/milly  /etc/autofs/auto.home.milly
> /home/es  /etc/autofs/auto.home.es
> ********* auto.home.milly
> ./              -fstype=nfs,rw          myhost:/home/milly
> 
> It seems I can't use ./ as key nor I can have /home/es in auto.master 
> and have Data as key in auto.home.es because it will mount /home/es 
> hidding the content of /home/es.

You might like to try a multi mount entry like

milly	myhost:/home/milly
es	/	myhost:/home/es	\
	/data	otherhost:/home/data

Note that multi mount map entries mount and umount all their entries as 
a single unit because of the cross filesystem issues that can arise. So in 
this case /home/es and /home/es/data would be mounted and umounted 
together.

Ian
