From: raven@themaw.net
Subject: Re: homedir mounts with 0 files
Date: Thu, 12 Feb 2004 22:33:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402122231320.5725@raven.themaw.net>
References: <200402120648.i1C6m4s7030467@deakin.edu.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200402120648.i1C6m4s7030467@deakin.edu.au>
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
To: Matthew Johnson <johnno@deakin.edu.au>
Cc: autofs@linux.kernel.org

On Thu, 12 Feb 2004, Matthew Johnson wrote:

> Anyone seen any behaviour like this .. 
> any suggestions/help ..
> 
> Continual recurrence of this in /var/log/messages
>                                                                                 
> Feb 10 02:24:22 server_name automount[20711]: BUG: /home/user1 already mounted
> Feb 10 02:24:22 server_name automount[20712]: BUG: /home/user2 already mounted
> ...
> Feb 10 02:24:22 server_name automount[20713]: BUG: /home/usern already mounted
>                                                                                 
>                                                                                 
> Some users home directories are mounted incorrectly.
> Not seeing any files.
> After unmount autofs then mounts it back in correctly.
> But problem is recurring.
> 
> Linux kernel 2.4.24
> autofs 4.1.0

What's in your master and indirect map?

Ian
