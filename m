From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: autofs not unmounting mount points?
Date: Fri, 12 Mar 2004 09:59:22 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE718D44DD@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: jansen <jansen@astro.wisc.edu>, autofs@linux.kernel.org

Hi Stephan,

I noticed that my Fedora box running autofs-4 likes to do this
when I log into a gnome session.  I have about 240 keys in my
auto.home map and it looks like it picks up all of those as well
as some others from other maps.  The mounts usually unmount after
a little while (I've never sat and timed how long it takes).

I don't recall ever observing this behavior with KDE, but I had
other issues which drove me to gnome.

-Steve

-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org]On Behalf Of jansen
Sent: Friday, March 12, 2004 9:46 AM
To: autofs@linux.kernel.org
Subject: [autofs] autofs not unmounting mount points?



Hi,

I've been struggling to figure out why autofs does not appear
to unmount many mount points.  I have more than 150 entries in
a map file and most of these entries get mounted when I log into
a Gnome session and never seem to ever get unmounted.  This
happened under RedHat 8.0 (autofs-3.1.7-33) and still happens on
SuSE 9.0 (autofs-3.1.7-717).  I'm guessing that Nautilus is doing
this.  Is anyone else seeing this?  Any suggestions on how to prevent
or debug this?  I can provide more details if anyone is interested.

-- 


------- Stephan

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
