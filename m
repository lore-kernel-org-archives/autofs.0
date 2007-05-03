From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: sasl plugin compilation failure
Date: Thu, 3 May 2007 14:32:08 -0700
Message-ID: <20070503213207.GA29009@qctesweb.qualcomm.com>
References: <44EC6AC2.3050503@inria.fr>
	<Pine.LNX.4.64.0608241027270.3051@raven.themaw.net>
	<44ED4AC8.1070903@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <44ED4AC8.1070903@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Thu, Aug 24, 2006 at 08:44:24AM +0200, Guillaume Rousse wrote:

> >> In file included from cyrus-sasl.c:59:
> >> ../include/lookup_ldap.h:41: error: expected specifier-qualifier-list
> >> before 'krb5_principal'
> >>
> >> I had to disable sasl explicitely. I'm using gcc 4.1.1.
> > 
> > What version and what patches?
> 5.0.1, with all patches applied until autofs-5.0.1-rc1-shutdown-races.patch.

I've run into the same thing on sled10.  Did you figure out a fix for
this?

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Sideshow Bob: "I'll be back.  You can't keep the Democrats out of the white 
house forever, and when they get in, I'm back on the street... with all my 
criminal buddies!  Aaah ha ha ha!" ==> Simpsons.
