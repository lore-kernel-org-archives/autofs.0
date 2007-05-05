From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: sasl plugin compilation failure
Date: Fri, 4 May 2007 17:16:44 -0700
Message-ID: <20070505001644.GG16190@cornholio.qualcomm.com>
References: <44EC6AC2.3050503@inria.fr>
	<x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
	<20070504210921.GD16190@cornholio.qualcomm.com>
	<x49abwkguch.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49abwkguch.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, May 04, 2007 at 05:19:26PM -0400, Jeff Moyer wrote:

> Hmm, can you add a:
> #include <krb5.h>
> 
> to include/lookup_ldap.h ?

Yep.. that did it.   Compiles and links against libsasl2.so now.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
SCCS, the source motel!  Programs check in and never check out!  - Ken
Thompson
