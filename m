From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs - nfs with localhost
Date: Thu, 10 Feb 2005 13:12:34 -0500
Message-ID: <16907.42002.201785.995963@segfault.boston.redhat.com>
References: <20050209170812.GA3000@hamburg.neofonie.priv>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050209170812.GA3000@hamburg.neofonie.priv>
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
Content-Type: text/plain; charset="us-ascii"
To: Rasmus Hahn <rassahah@neofonie.de>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs - nfs with localhost; Rasmus Hahn <rassahah@neofonie.de> adds:

rassahah> Hello Mr & Mrs Autofs-Reader, im using autofs-4.1.3 and want to
rassahah> use an map-entry like

rassahah>   -port=12215,mountport=12215,nfsvers=3,soft,tcp,ro localhost:/.

rassahah> For some reason the automounter believes in beeing smarter than
rassahah> me, and instead of mounting using the nfs daemon it could find on
rassahah> port 12215 it uses a `mount --bind' to mount the root filesystem
rassahah> without nfs.  How can i disable this to force automount to use
rassahah> NFS? The manpages didnt reveal anything about this, is it an
rassahah> experimental feature?

rassahah> (background: actually i dont want to remount my / somewhere else,
rassahah> but using an ssh-tunnel on port 12215 with an nfsd on the other
rassahah> end).

Sorry, there is no option to configure that.  So is this a feature request?
;)

-Jeff
