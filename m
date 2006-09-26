From: Fajar Priyanto <fajarpri@cbn.net.id>
Subject: Re: 
	=?iso-8859-15?q?SOLVED=3F=3F_Pls_help_on_configuring_aut?=
	=?iso-8859-15?q?ofs_on_NFS_for=09home_dir?=
Date: Tue, 26 Sep 2006 20:47:21 +0700
Message-ID: <200609262047.22505.fajarpri@cbn.net.id>
References: <200609261119.47084.fajarpri@cbn.net.id>
	<200609261143.12477.fajarpri@cbn.net.id>
	<45192426.3040108@onsemi.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45192426.3040108@onsemi.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

On Tuesday 26 September 2006 19:59, Dana Wellen wrote:
>  Fajar,
>  =A0 I assume you want your nfstest user to mount their home directory in
> /home.=A0 Your autofs files should be:
>  auto.master
>  /home=A0=A0 =A0=A0 /etc/auto.home --timeout=3D60
>  auto.home
> *       -rw,soft,intr   192.168.1.247:/home/&

Hi Dana,
Thank you very much for replying.
Actually, that was one of the first configurations I tried, but, when I tri=
ed =

it, autofs couldn't be started with error:
"Cannot start automount. =

/home already mounted"

I don't know, maybe it's because I have done some mistakes before. But, I =

couldn't restart the machine since it's my running mail server (shame on me =

by experimenting on a production server).

I'll setup some boxes at home to try it again.
I'll post the result.
-- =

Fajar Priyanto | Reg'd Linux User #327841 | Linux tutorial =

http://linux2.arinet.org
8:46pm up 0:17, 2.6.16.13-4-default GNU/Linux =

Let's use OpenOffice. http://www.openoffice.org
