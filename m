From: Manolis Tzanidakis <mtzanidakis@freemail.gr>
Subject: [Feature request] foreground daemon process
Date: Thu, 3 Jun 2004 17:13:28 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040603171328.1e9b8030@blade.matza.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-8859-7"
To: autofs@linux.kernel.org

Hello all,
I'm using runit (djb's daemontools-alike init w/ service supervision)
instead of sysvinit as process 1 and I' d like to run the automount
daemon supervised with it. Could you pls add an option or something in
automount to make it stay in the foreground ?
It'd be useful to others for debugging etc. IMO.

ps. Unfortunately I' m not much of a coder to implement it myself &
contribute it back :(.

--=20
.: Manolis Tzanidakis
mailto: mtzanidakis@freemail.gr
http://www.kegep.tuc.gr/~manolis
jabber: mtzanidakis@jabber.org
icq: #102798230
GnuPG Key Fingerprint:
5CA5 41D6 09F1 C4B9 C331
65EF 4B3F 6979 EB8C 88F3

____________________________________________________________________
http://www.freemail.gr - =E4=F9=F1=E5=DC=ED =F5=F0=E7=F1=E5=F3=DF=E1 =E7=EB=
=E5=EA=F4=F1=EF=ED=E9=EA=EF=FD =F4=E1=F7=F5=E4=F1=EF=EC=E5=DF=EF=F5.
http://www.freemail.gr - free email service for the Greek-speaking.
