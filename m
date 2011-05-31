From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] FedFS file system client support
Date: Tue, 31 May 2011 11:14:01 -0400
Message-ID: <8F5C8CC6-7F25-4F88-8877-F731E4BAB1A6@oracle.com>
References: <20110526163545.3676.52586.stgit@dali.1015granger.net>
	<1306728920.3292.3.camel@perseus.themaw.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1306728920.3292.3.camel@perseus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, fedfs-utils-devel@oss.oracle.com


On May 30, 2011, at 12:15 AM, Ian Kent wrote:

> On Thu, 2011-05-26 at 12:39 -0400, Chuck Lever wrote:
>> Hi-
>> 
>> The next release of fedfs-utils will provide all necessary components
>> for a Linux NFS client to participate in a FedFS domain as a file
>> system client.  This new utility is intended to be a part of the
>> upcoming release.
>> 
>> I'm interested in comments on this approach.  Ian had suggested a new
>> lookup module, but a program map looked simpler to prototype and has
>> the great advantage of no dependencies between fedfs-utils and autofs.
>> If program maps have some nasty problem that require the use of a
>> lookup module, we can take that next step.
> 
> The only difficulty with using a program map is that to use it you need
> to know the name of the of the <key> (aka. /nfs4/<key>) since, at the
> moment, autofs can't enumerate program map keys.

If I understand your comment correctly, the problem is how the client discovers FedFS domain names to use as keys.

As I understand it, FedFS does not currently have a mechanism for clients to discover FedFS domain names, like, say, AFS did with CellServDB.

Also, FedFS file system clients don't belong to a particular domain, so they don't have any idea what might be their "local" domain.  Any client can access any domain; security is provided by the underlying file system protocols.  The domains are just a way to organize the name spaces, without any regard to security administrative domains.

Thus, right now users and applications have to know a priori the whole pathname (or, Globally Useful Name, in FedFS parlance) in order to access a file resource via FedFS.

Are you suggesting there is a better design we could adopt that might prepare FedFS for a time when there is a mechanism for discovering FedFS domain names?

-- 
Chuck Lever
chuck[dot]lever[at]oracle[dot]com
