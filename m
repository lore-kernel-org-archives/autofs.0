From: Robert Giles <rgiles@arlut.utexas.edu>
Subject: Re: Infinite loop when trying to access nonexistent
  directory (auto.home '&' substitution)
Date: Wed, 20 Oct 2004 14:55:18 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6.1.2.0.2.20041020143753.036f5ca0@mail.utexas.edu>
References: <Pine.LNX.4.61.0410201431520.8936@orion.arlut.utexas.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410201431520.8936@orion.arlut.utexas.edu>
References: <Pine.LNX.4.61.0410201431520.8936@orion.arlut.utexas.edu>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Ack, well I recompiled 2.4.27 without SNARE auditing patches and autofs
appears to be working normally.

So this is without a doubt related to SNARE...

Going to compare the strace output under the "clean" kernel now...
(hopefully the problem will be apparent).

Robert Giles
ARL:UT
