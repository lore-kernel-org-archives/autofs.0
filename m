From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Status of >800 mounts
Date: Fri, 7 May 2004 09:13:27 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16539.35703.175832.70086@segfault.boston.redhat.com>
References: <409A7A7C.2000109@sedona.intel.com>
	<20040506185528.GA5149@crashy.west.sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040506185528.GA5149@crashy.west.sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Stew Smith <stew.smith@sun.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Status of >800 mounts; Stew Smith <stew.smith@sun.com> adds:

stew.smith> On Thu, May 06, 2004 at 10:48:44AM -0700, Michael Blandford
stew.smith> wrote:
>> Hello,
>> 
>> What is the current status of having more than 800 nfs mounts ( on 2.4
>> and 2.6 )?
>> 
>> I had heard there might be a patch to use one port per server instead of
>> per mount.
>> 

stew.smith> i am working on a patch currently which multiplexes nfs
stew.smith> connections per sever so you end up with a 800 server limit,
stew.smith> similar to the way nfsv4 works now.. i will send it out for
stew.smith> review very soon after i ferret out a few bugs.

stew.smith> another idea we had was to add SO_REUSEADDR to rpc sockets so
stew.smith> you have more available on a busy system.

Are you going to post the patches (or have you already) to the linux-nfs
list?  If enough people find it useful, would be nice to get it upstream.

-Jeff
