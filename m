From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: network timeout needed at startup
Date: Wed, 06 Sep 2006 13:13:42 +0200
Message-ID: <44FEAD66.7060106@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

When using LDAP (and probably other network resources) to store master
map, the network has to be available at autofs daemon start. As Linux
distributions boot time is currently diminushing (hotplug replaced by
udev, various parallelisation effort), I see various race conditions
occuring: the network service finishes, but the actual network interface
is still in initialisation state, leading to autofs start failure.

The primary problem comes from network service implementation, and
should probably get fixed there, right. However, I also think than
having a configurable network timeout directly in autofs (aka: wait at
least 10 second before considering the server is down) may also help in
other scenarios. For instance, when you start various machine
simultaneously (for instance, after a general power down), and your
server takes longer to boot than your workstation.

With autofs 4, I implemented this in service script. Now than everything
is handled by autoumout daemon, this should get implemented there I think.
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
