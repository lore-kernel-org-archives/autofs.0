From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: sasl plugin compilation failure
Date: Fri, 04 May 2007 17:19:26 -0400
Message-ID: <x49abwkguch.fsf@segfault.boston.devel.redhat.com>
References: <44EC6AC2.3050503@inria.fr>
	<x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
	<20070504210921.GD16190@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070504210921.GD16190@cornholio.qualcomm.com> (Mike Marion's
	message of "Fri, 4 May 2007 14:09:22 -0700")
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

==> On Fri, 4 May 2007 14:09:22 -0700, Mike Marion <mmarion@qualcomm.com> said:

Mike> On Thu, May 03, 2007 at 05:46:18PM -0400, Jeff Moyer wrote:
Mike> > Guillaume> I had to disable sasl explicitely. I'm using gcc 4.1.1.  --
Mike> > Guillaume> Guillaume Rousse Projet Estime, INRIA Domaine de Voluceau
Mike> > Guillaume> Rocquencourt - B.P. 105 78153 Le Chesnay Cedex - France
Mike> > 
Mike> > Do you have krb5 development libraries installed?

Mike> I know I do... SLED10 install.. all the krb5* rpms are installed (64 and
Mike> 32bit including -devel*) and all the openssl ones too.  

Mike> I was able to disable sasl for now too, which is ok for the short term
Mike> because we'd like to use sasl eventually.

Hmm, can you add a:
#include <krb5.h>

to include/lookup_ldap.h ?

-Jeff
