From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: Autofs doesn't look at second LDAP server
Date: Thu, 17 Jul 2008 20:34:25 +0200
Message-ID: <487F90B1.1090405@inria.fr>
References: <BAC1D28A5AB852439A6914CA7AB4E63F05192E66@permls05.wde.woodside.com.au>
	<1216264449.22783.66.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1216264449.22783.66.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

Ian Kent a =E9crit :
> I wonder if it's getting the server from the config at all?
> It should be.
> =

> LDAP_URI=3D"ldaps://ldap2.woodside.com.au:636 ldaps://ldap1.woodside.com.=
au:636"
If this isn't explicitely set in autofs configuration, are the different =

servers configured for openldap library used instead ?
