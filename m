From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Re: [ANNOUNCE] autofs v4 beta3 (fwd)
Date: Thu, 13 Nov 2003 09:16:17 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FB3BC61.8060005@intel.com>
References: <Pine.LNX.4.33.0311131542180.11228-100000@wombat.indigo.net.au>
	<3FB397B9.9010600@rhythm.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

Greg Bradner wrote:
> I have multiple mount points on a NetApp, but I don't have 'access' 
> permissions to all of them.  When autofs encountered a permission denied 
> on one of the mount points, it didn't mount any of them.  Shouldn't it 
> just skip over the permission denied one and still mount the others?

That is what the nonstrict option is for.

Forrest
-- 
