From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: timeouts on update of /etc/autofs.[conf] file not read v. fast
Date: Wed, 22 Sep 2004 18:21:20 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040922172120.GA7308@lkcl.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

hi,

i notice that failed attempts to access an autofs managed mountpoint
result in a sort of "black hole" period of somewhere around thirty
seconds, during which time the media cannot be accessed.

after this "black hole" period has expired, handle_packet() suddenly...
just... wakes up!  up until that time, any attempts to do an ls
/media/floppy are just... ignored.

what's goin on?

ta,

l.

Sep 22 18:17:29 localhost automount[11118]: get_pkt: state 3, next 2
Sep 22 18:17:29 localhost automount[11118]: st_ready(): state = 3
Sep 22 18:17:30 localhost automount[11118]: sig 14 switching from 2 to 3
Sep 22 18:17:30 localhost automount[11118]: get_pkt: state 2, next 3
Sep 22 18:17:30 localhost automount[11118]: st_expire(): state = 2  
Sep 22 18:17:30 localhost automount[11118]: expire_proc: exp_proc=11317
Sep 22 18:17:30 localhost automount[11118]: st_expire(): exp = 1  
Sep 22 18:17:30 localhost automount[11118]: handle_child: got pid 11317,
sig 0 (0), stat 0 
Sep 22 18:17:30 localhost automount[11118]: sigchld: exp 11317 finished,
switching from 3 to 2
Sep 22 18:17:30 localhost automount[11118]: get_pkt: state 3, next 2
Sep 22 18:17:30 localhost automount[11118]: st_ready(): state = 3
Sep 22 18:17:31 localhost automount[11118]: sig 14 switching from 2 to 3 
Sep 22 18:17:31 localhost automount[11118]: get_pkt: state 2, next 3
Sep 22 18:17:31 localhost automount[11118]: st_expire(): state = 2 
Sep 22 18:17:31 localhost automount[11118]: expire_proc: exp_proc=11318
Sep 22 18:17:31 localhost automount[11118]: st_expire(): exp = 1
Sep 22 18:17:31 localhost automount[11118]: handle_child: got pid 11318,
sig 0 (0), stat 0
Sep 22 18:17:31 localhost automount[11118]: sigchld: exp 11318 finished,
switching from 3 to 2
Sep 22 18:17:31 localhost automount[11118]: get_pkt: state 3, next 2
Sep 22 18:17:31 localhost automount[11118]: st_ready(): state = 3
Sep 22 18:17:31 localhost automount[11118]: handle_packet: type = 0
Sep 22 18:17:31 localhost automount[11118]: handle_packet_missing: token
4, name floppy
Sep 22 18:17:31 localhost automount[11118]: attempting to mount entry
/media/floppy

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />
