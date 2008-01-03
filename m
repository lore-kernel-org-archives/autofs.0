From: Ian Kent <raven@themaw.net>
Subject: Re: Slow mounts when using large round robin sets
Date: Thu, 03 Jan 2008 10:34:00 +0900
Message-ID: <1199324040.3175.4.camel@raven.themaw.net>
References: <98E55D6E1B3CFD43BDA59EEB56DD7D72442DF1@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724432D5@sbs01.xiss.private>
	<x49zlwm5hf1.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D7244386E@sbs01.xiss.private>
	<1198241367.3488.26.camel@raven.themaw.net>
	<x49odck175r.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438C2@sbs01.xiss.private>
	<x49fxxvzpp5.fsf@segfault.boston.devel.redhat.com>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724438CB@sbs01.xiss.private>
	<1198304664.3114.49.camel@raven.themaw.net>
	<1198307519.3114.59.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443928@sbs01.xiss.private>
	<1198739265.3169.81.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D72443981@sbs01.xiss.private>
	<1198822909.3089.28.camel@raven.themaw.net>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724BEEFA@sbs01.xiss.private>
	<98E55D6E1B3CFD43BDA59EEB56DD7D724BEF72@sbs01.xiss.private>
	<1199285141.3072.50.camel@raven.themaw.net>
	<alpine.LFD.0.9999.0801021742120.1247@honker.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LFD.0.9999.0801021742120.1247@honker.vgersoft.com>
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
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Wed, 2008-01-02 at 17:43 -0500, Steve Thompson wrote:
> On Wed, 2 Jan 2008, Ian Kent wrote:
> 
> > But, when multiple addresses are returned, autofs uses them as though
> > they were multiple names and checks to see if they are up and what the
> > response to an NULL procedure ping is so it can put them in least loaded
> > order, assuming the servers are at the same proximity.
> 
> How about dividing those IP addresses into two sets: those on the same
> subnet as the client and those that aren't, and then proceding as
> above? That might save a hop or two for "close" clients.

From the comment in modules/replicated.c (including spelling mistakes):

A priority ordered list of hosts is created by using the following
selection rules.

   1) Highest priority in selection is proximity.
      Proximity, in order of precedence is:
        - PROXIMITY_LOCAL, host corresponds to a local interface.
        - PROXIMITY_SUBNET, host is located in a subnet reachable
          through a local interface.
        - PROXIMITY_NETWORK, host is located in a network reachable
          through a local interface.
        - PROXIMITY_OTHER, host is on a network not directlty
          reachable through a local interface.

   2) NFS version and protocol is selected by caclculating the largest
      number of hosts supporting an NFS version and protocol that
      have the closest proximity. These hosts are added to the list
      in response time order. Hosts may have a corresponding weight
      which essentially increaes response time and so influences the
      host order.

   3) Hosts at further proximity that support the selected NFS version
      and protocol are also added to the list in response time order as
      in 2 above.

At least that's how I think it works and hopefully I haven't changed
that with subsequent changes.

Ian
