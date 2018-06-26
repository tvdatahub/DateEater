using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace CoreWeb.Controllers
{
    [Route("api/[controller]")]
    public class ValuesController : Controller
    {
        // GET api/values
        [HttpGet]
        public object Get()
        {
            return new { now = DateTime.Now, zone = TimeZoneInfo.Local };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public object Get(int id)
        {
            return new { now = DateTime.Now, zone = TimeZoneInfo.Local.Id, value = "value" + id };
        }

        // POST api/values
        [HttpPost]
        public object Post([FromBody]DateTime value)
        {
            return new { now = DateTime.Now, zone = TimeZoneInfo.Local.Id, yourTime = value };
        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public object Put(int id, [FromBody]DateTimeOffset value)
        {
            return new { now = DateTime.Now, zone = TimeZoneInfo.Local.Id, value = "value" + id, yourTime = value };
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public object Delete(int id)
        {
            return new { now = DateTime.Now, zone = TimeZoneInfo.Local.Id, value = "value" + id };
        }
    }
}
