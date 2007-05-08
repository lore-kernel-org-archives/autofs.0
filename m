From: "Mike Marion" <mmarion@qualcomm.com>
Subject: Re: sasl plugin compilation failure
Date: Mon, 7 May 2007 22:47:14 -0700
Message-ID: <20070508054714.GB9023@manzana.miguelito.org>
References: <44EC6AC2.3050503@inria.fr>
	<x49bqh1inrp.fsf@segfault.boston.devel.redhat.com>
	<20070504210921.GD16190@cornholio.qualcomm.com>
	<x49abwkguch.fsf@segfault.boston.devel.redhat.com>
	<20070505001644.GG16190@cornholio.qualcomm.com>
	<m3irb4x1kv.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <m3irb4x1kv.fsf@redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Mon, May 07, 2007 at 08:25:36AM -0400, jmoyer@redhat.com wrote:

> Ian, it seems we need this patch.  I have no idea how things build without
> it!  Additionally, we should add some configure magic to check for the krb5
> development libraries.

The builds on our sles9-sp3 hosts all worked fine... they appeared to
not even bother trying sasl.  I'm guessing that's what's happening for
most people, it's not seeing something and just not even trying sasl.  

The builds that failed for me were on sles/sled10 vs sles9-sp3.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Ralph: "Oh yes, Larry Benson... the x1000.  Worked out better then you dreamed, 
didn't they?" 
Larry: "Actually there was a little bit of a problem."
Ralph: "Then it's with your software!" -- Small Soldiers.. sounds like most
Chip and OS companies though. :)
