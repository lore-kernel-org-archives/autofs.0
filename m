From: Robert Giles <rgiles@arlut.utexas.edu>
Subject: Re: LDAP-based auto.master and --ghost option
Date: Tue, 3 Oct 2006 08:48:46 -0500
Message-ID: <Pine.CYG.4.64.0610030845570.820@ninja>
References: <Pine.CYG.4.64.0609291328430.468@ninja>
	<1159809769.2905.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1946940793-1159883326=:820"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1159809769.2905.16.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1946940793-1159883326=:820
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Oct 2006, Ian Kent wrote:
> Maybe a workaround would be to set DAEMONOPTIONS equal to "--ghost" in
> the startup configuration file. Wherever that may be on your distro.

That worked perfectly, thanks for the tip.

(for future reference / folks searching through list archives...)

SuSE 10.1
/etc/sysconfig/autofs:

AUTOFS_OPTIONS=3D"--ghost"

(yeah, it'd be nice to have --ghost pushed out via LDAP, but this does the=
=20
trick)

-----------------------------------------------------------
Robert Giles                     Group System Administrator
SPD/ARL:UT              (512) 835-3077 =B7 Fax (512) 490-4244
---559023410-1946940793-1159883326=:820
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

---559023410-1946940793-1159883326=:820--

