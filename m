From: Rasmus Hahn <rassahah@neofonie.de>
Subject: autofs - nfs with localhost
Date: Wed, 9 Feb 2005 18:08:12 +0100
Message-ID: <20050209170812.GA3000@hamburg.neofonie.priv>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hello Mr & Mrs Autofs-Reader,

im using autofs-4.1.3 and want to use an map-entry like

  -port=12215,mountport=12215,nfsvers=3,soft,tcp,ro localhost:/.

For some reason the automounter believes in beeing smarter than me,
and instead of mounting using the nfs daemon it could find on port 12215
it uses a `mount --bind' to mount the root filesystem without nfs.
How can i disable this to force automount to use NFS? The manpages didnt
reveal anything about this, is it an experimental feature?

(background: actually i dont want to remount my / somewhere else, but using
an ssh-tunnel on port 12215 with an nfsd on the other end).

Greetings - Rasmus

-- 
