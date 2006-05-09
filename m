From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Umount call getting stuck, hanging nfs?
Date: Mon, 8 May 2006 18:31:12 -0700
Message-ID: <20060509013111.GK9873@cornholio.qualcomm.com>
References: <20060504204141.GO27751@cornholio.qualcomm.com>
	<Pine.LNX.4.64.0605050955571.2898@raven.themaw.net>
	<20060508233437.GG9873@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060508233437.GG9873@cornholio.qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Mon, May 08, 2006 at 04:34:38PM -0700, Mike Marion wrote:

> > Tell us what the maps look like.
> 
> The noted path is like this:
> /prj/dsp/qdsp6 -rw,acdirmin=1,acdirmax=5,acregmin=1,acregmax=5,rsize=32768,wsize=32768,noquota
> western:/vol/eng_aus_0004/qdsp6

Oops..  that's the direct map entry and the host in question is using
program maps (the problem happens on hosts using direct maps or program
maps).

The path in question on that host looks like:
/usr/local/projects/dsp/qdsp6  -rw,noquota western:/vol/eng_aus_0004/qdsp6

Hmm.. I didn't realize they weren't getting the other options.  Though
like I said, it happens with the above and program maps, or the direct
map entry shown in the quoted bit.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Mayor: "Their little festival should pump some money into the local economy."
Cartman: "They're hippies!! They don't have any money!!" ==> South Park.
