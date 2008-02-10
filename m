From: Stef Bon <sbon@bononline.nl>
Subject: Re: bind mounting into a generated multi-level directory
 structure
Date: Sun, 10 Feb 2008 15:18:39 +0100
Message-ID: <47AF07BF.2040405@bononline.nl>
References: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802090220120.18112@potato.cts.ucla.edu>
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

Chris Stromsoe wrote:
> I have a set of directories that are created and removed programmatically, 
> and are hashed three levels deep (/top/hash/hash/name).  The depth is 
> constant, the hashes and names are not.  There are around 35k at any time. 
> I would like to bind mount a common directory into each top-level 
> (/top/hash/hash/name/data) on demand.
>
> Can I use autofs to do that without having to explicitly list all of the 
> directory paths in auto.master?
>   
Why not use symlinks to this shared common directory, and mount that one?

Stef Bon
