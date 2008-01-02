From: "Jerzy Jalocha N" <jjalocha@gmail.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 2 Jan 2008 13:10:16 -0600
Message-ID: <9b72f9a90801021110k3b3d74e7kb227b1e5bb772544@mail.gmail.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
	<x49lk7812d7.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49lk7812d7.fsf@segfault.boston.devel.redhat.com>
Content-Disposition: inline
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

> Try:
>
> auto.master:
> /shared /etc/auto.shared
>
> /etc/auto.shared:
> *       -hard,intr      192.168.1.20:/shared/&

Thanks, Jeff, but sorry, that doesn't work. It's one of the first
settings I had. Tried it again now, but without success. 'ls' just
shows nothing, even with 'cd /shared'.

Any other ideas?
