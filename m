From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 release
Date: Sun, 10 Apr 2005 16:44:16 +0200
Message-ID: <20050410144416.GB23740@uio.no>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
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

On Sun, Apr 10, 2005 at 09:38:50PM +0800, raven@themaw.net wrote:
> Here is autofs 4.1.4.

Looks like the Debian init script is broken to me:

  kanskje:~# /etc/init.d/autofs start
  Starting automounter:start-stop-daemon: --start needs --exec or --startas
  Try `start-stop-daemon --help' for more information.

   failed to start automount point /home/cassarossa

Looks like you've over-applied the fix for --stop onto --start as well.
Changing "--name $dname" into "--exec $DAEMON" in "start" in the init script
seems to fix it.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
