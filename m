From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: autofs no_local_binds option (nfs <-> bind mounts)
Date: Tue, 13 Jan 2004 09:14:28 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40042774.7070003@zytor.com>
References: <F3123864FB69D411946000D0B77FBBDF0D5E13EF@haendel.bbn.hp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <F3123864FB69D411946000D0B77FBBDF0D5E13EF@haendel.bbn.hp.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "MARX,ALEXANDER (HP-Germany,ex1)" <alexander.marx@hp.com>
Cc: autofs@linux.kernel.org

MARX,ALEXANDER (HP-Germany,ex1) wrote:
> 
> In some scenarios (e.g. HA), the nfs server could switch from local to
> remote, therefore having local binds is not a desirable scenario, there
> should always be nfs mounts.
> 

How would you expect this to work?  The local bind only happens when 
local and destination address are the same, therefore keeping anything 
from going across the network no matter how you slice it.

Changing the DNS name of the NFS server has no effect, since once the 
mount has happened the name was already resolved, and it can't be 
redirected.

Changing the IP address runs into the problem that local == remote.

	-hpa
