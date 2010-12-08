From: Ian Kent <ikent@redhat.com>
Subject: Re: NFSv4 to be a default on RHEL-6
Date: Wed, 08 Dec 2010 20:36:05 +0800
Message-ID: <1291811765.17231.6.camel@perseus>
References: <4CFF4CE8.6080708@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4CFF4CE8.6080708@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Wed, 2010-12-08 at 10:16 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> I have just noticed that on RHEL-6 is NFSv4 a default filesystem for
> NFS. However, when I browse using automounter & /net, all folders are
> mounted via NFSv3. That's a bit confusing.... shall we perhaps use
> nfs4 as a default in autofs, too?

The default should be determined by mount.nfs(8) since that's what
autofs uses to perform mounts.

There are more issues when you are using an NFSv4 global root since
there is no way for a client to know what that global root is, that
information is not present in the exports information. So, the server
must honor mounts that append the global root to the server mount path
and also those which don't.

Ian
