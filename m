From: "Kevin Muller" <k.muller@sideshowdigital.com>
Subject: autofs / davfs
Date: Fri, 18 May 2007 09:08:00 +0300
Message-ID: <4104f1cf0705172308pdd3a3f9l4b4a558e290bebbc@mail.gmail.com>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
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

autofs / davfs

Im having a problem automounting a davfs share.
The share is setup, and works perfect without the automount.
but as soon as a 'ls' is done on the automount directory, and the
autofs tries to mount it, it hangs for a while, then if ctrl-c's out
of it, the next ls on that directory shows the files correctly.

The idea is to have the files available through Samba, and as soon as
samba tries to access the folder it will be a webdav share that gets
mounted at that point.

Any suggestions at this point will be helpful.

Kevin
