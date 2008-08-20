From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Automounter hangs...
Date: Wed, 20 Aug 2008 09:56:00 -0400
Message-ID: <x49pro3yemn.fsf@segfault.boston.devel.redhat.com>
References: <48A03A9B.2070402@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48A03A9B.2070402@s3group.cz> (Ondrej Valousek's message of "Mon, 
	11 Aug 2008 15:11:55 +0200")
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

Ondrej Valousek <webserv@s3group.cz> writes:

> Hi List,
>
> I have strange error (RHEL-4, autofs 4.1.3-234). Using automounter to
> mount home directories for users. After a while, /home got unusable and
> I see the following:
>
> root     17345 20453  0 10:33 ?        00:00:00 [automount] <defunct>
> root     17348 20453  0 10:33 ?        00:00:00 [automount] <defunct>
> root     20453     1  0 Aug05 ?        00:00:15 /usr/sbin/automount
> --timeout=60 --debug /home yp auto.home -rw
>
>
> I can not kill any of the processes listed (tried even kill -9).
> The last I can see in /var/log/messages is the following:
> Aug 11 10:32:39 login01 automount[17100]: expired /home/login
> Aug 11 10:33:01 login01 automount[20453]: attempting to mount entry
> /home/login
> Aug 11 10:33:01 login01 automount[17185]: mount(nfs): mounted
> belfast:/vol/users/users/login on /home/login
> Aug 11 10:33:09 login01 automount[17346]: expired /home/localmgr
> Aug 11 10:33:09 login01 automount[17348]: expired /home/support
>
> Maybe, the processes 17346 and 17348 failed to unmount /home/support and
> /home/localmgr. This perhaps caused even the parent process 20453 to hang.
>
> Has anyone seen anything similar? Is there any solution to this?
> Thanks,

It rings a bell, but I can't put my finger on it.  Can you reproduce
this?  If so, could you send along a debug log?  Instructions for
collecting debug information can be found at:
  http://people.redhat.com/~jmoyer/

Cheers,

Jeff
