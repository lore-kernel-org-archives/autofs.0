From: Darlene D Choontanom <dchoontanom@raytheon.com>
Subject: weighting factor?
Date: Tue, 21 Apr 2009 10:43:58 -0700
Message-ID: <OFA7BAAD33.0A4CD567-ON8825759F.00604D01-8825759F.006168EB@mck.us.ray.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0160072187854984955=="
Return-path: <autofs-bounces@linux.kernel.org>
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

This is a multipart message in MIME format.
--===============0160072187854984955==
Content-Type: multipart/alternative; boundary="=_alternative 006168E68825759F_="

This is a multipart message in MIME format.
--=_alternative 006168E68825759F_=
Content-Type: text/plain; charset="US-ASCII"

Hi, all--

Apologies in advance if this has been asked before, but I'm running into 
issues with a shared NIS auto.home file we're trying to stand up between 
two remote sites.  My clients are a mixture of Solaris and RHEL 3 & 4 
machines.  A sample entry in question reads:

foo     thisserver:/export/home4/& \
        thatserver:/export/home10/&

The Sun clients work fine, automounting the server closest to them 
geographically.  The Linux boxes, however, all seem to want to mount 
"thatserver", regardless of how far the distance is between them.  I tried 
weighting them:

foo     thisserver(1):/export/home4/& \
        thatserver(9):/export/home10/&

But while that seems to work okay for some of my RHEL boxes, it doesn't 
seem to get recognized on others.  I'd like to try to restart the 
automounter on the non-working clients, but since they're all in 
production, it'll be a little tricky if I don't want to impact my users.

Is this a known problem, or is there a fix?  The weighting factor really 
will only fix the clients closest to "thisserver" ; I'd rather not force 
the clients close to "thatserver" to have to go to a remote box if there's 
a closer one they should be mounting, instead.

Thanks--
Darlene

---
dchoontanom@raytheon.com                                        Raytheon 
Company
310.334.5478
--=_alternative 006168E68825759F_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi, all--</font>
<br>
<br><font size=2 face="sans-serif">Apologies in advance if this has been
asked before, but I'm running into issues with a shared NIS auto.home file
we're trying to stand up between two remote sites. &nbsp;My clients are
a mixture of Solaris and RHEL 3 &amp; 4 machines. &nbsp;A sample entry
in question reads:</font>
<br>
<br><font size=2 face="sans-serif">foo &nbsp; &nbsp; &nbsp; &nbsp;thisserver:/export/home4/&amp;
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; thatserver:/export/home10/&amp;</font>
<br>
<br><font size=2 face="sans-serif">The Sun clients work fine, automounting
the server closest to them geographically. &nbsp;The Linux boxes, however,
all seem to want to mount &quot;thatserver&quot;, regardless of how far
the distance is between them. &nbsp;I tried weighting them:</font>
<br>
<br><font size=2 face="sans-serif">foo &nbsp; &nbsp; &nbsp; &nbsp;thisserver(1):/export/home4/&amp;
\</font>
<br><font size=2 face="sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; thatserver(9):/export/home10/&amp;</font>
<br>
<br><font size=2 face="sans-serif">But while that seems to work okay for
some of my RHEL boxes, it doesn't seem to get recognized on others. &nbsp;I'd
like to try to restart the automounter on the non-working clients, but
since they're all in production, it'll be a little tricky if I don't want
to impact my users.</font>
<br>
<br><font size=2 face="sans-serif">Is this a known problem, or is there
a fix? &nbsp;The weighting factor really will only fix the clients closest
to &quot;thisserver&quot; ; I'd rather not force the clients close to &quot;thatserver&quot;
to have to go to a remote box if there's a closer one they should be mounting,
instead.</font>
<br>
<br><font size=2 face="sans-serif">Thanks--<br>
Darlene</font>
<br>
<br><font size=2 face="sans-serif">---</font>
<br><font size=2 face="sans-serif">dchoontanom@raytheon.com &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;Raytheon Company</font>
<br><font size=2 face="sans-serif">310.334.5478</font>
--=_alternative 006168E68825759F_=--


--===============0160072187854984955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0160072187854984955==--

