From: Stew Smith <stew.smith@sun.com>
Subject: Re: Status of >800 mounts
Date: Thu, 6 May 2004 11:55:29 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040506185528.GA5149@crashy.west.sun.com>
References: <409A7A7C.2000109@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <409A7A7C.2000109@sedona.intel.com>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Thu, May 06, 2004 at 10:48:44AM -0700, Michael Blandford wrote:
> Hello,
> 
> What is the current status of having more than 800 nfs mounts ( on 2.4 
> and 2.6 )?
> 
> I had heard there might be a patch to use one port per server instead of 
> per mount. 
> 

i am working on a patch currently which multiplexes nfs connections
per sever so you end up with a 800 server limit, similar to the
way nfsv4 works now.. i will send it out for review very soon after
i ferret out a few bugs.

another idea we had was to add SO_REUSEADDR to rpc sockets so
you have more available on a busy system.

-- 
Stew Smith
