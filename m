From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs / davfs
Date: Fri, 18 May 2007 10:28:21 -0400
Message-ID: <x49zm428auy.fsf@segfault.boston.devel.redhat.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
	(Kevin Muller's message of "Fri, 18 May 2007 09:08:00 +0300")
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
To: Kevin Muller <k.muller@sideshowdigital.com>
Cc: autofs@linux.kernel.org

==> On Fri, 18 May 2007 09:08:00 +0300, "Kevin Muller" <k.muller@sideshowdigital.com> said:

Kevin> autofs / davfs
Kevin> Im having a problem automounting a davfs share.
Kevin> The share is setup, and works perfect without the automount.
Kevin> but as soon as a 'ls' is done on the automount directory, and the
Kevin> autofs tries to mount it, it hangs for a while, then if ctrl-c's out
Kevin> of it, the next ls on that directory shows the files correctly.

Kevin> The idea is to have the files available through Samba, and as soon as
Kevin> samba tries to access the folder it will be a webdav share that gets
Kevin> mounted at that point.

Kevin> Any suggestions at this point will be helpful.

See the section entitled, "Filing bug reports," at the following URL:
  http://people.redhat.com/jmoyer

Please provide the information requested therein.

Thanks!

Jeff
