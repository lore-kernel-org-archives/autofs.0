From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 patches for older kernels
Date: Mon, 05 Nov 2007 23:51:47 +0900
Message-ID: <1194274307.5626.3.camel@raven.themaw.net>
References: <472F2856.6090701@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <472F2856.6090701@kmaclub.com>
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
To: Michael <michael@kmaclub.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-11-05 at 07:27 -0700, Michael wrote:
> Hello,
> 
> I am running an older SuSE SLES9 release.  It ships with autofs-4.1.3 
> with a 2.6.5 kernel.
> 
> We are having a number of issues with the automount daemon dying on 
> certain mounts, failing to be responsive, etc in a rather large 
> environment. 
> 
> We would like to upgrade to autofs5 but the kernel shipped ( 2.6.5 ) 
> doesn't include support for autofs5 or a great number of patches that 
> have gone into 2.6.16+ kernels.
> 
> Is anyone maintaining a current autofs patch set against older 2.6.x 
> kernels?

Only back to 2.6.9.

Let me tell, you this really difficult.
I've already spent some time on it and it is hard work.
If I was able to get time to complete the port then you would need to be
prepared to help debug errors introduced in the transcription. There are
bound to be some as I don't have 2.6.5 based machines for testing.

Ian
